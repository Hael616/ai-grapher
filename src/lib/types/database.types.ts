export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      generations: {
        Row: {
          created_at: string
          credit_cost: number
          id: string
          image_url: string | null
          project_id: string
          prompt: string
          resolution: Database["public"]["Enums"]["resolution_type"]
          scene_type: Database["public"]["Enums"]["scene_type_type"]
          status: Database["public"]["Enums"]["generation_status_type"]
          user_id: string
        }
        Insert: {
          created_at?: string
          credit_cost: number
          id?: string
          image_url?: string | null
          project_id: string
          prompt: string
          resolution: Database["public"]["Enums"]["resolution_type"]
          scene_type: Database["public"]["Enums"]["scene_type_type"]
          status?: Database["public"]["Enums"]["generation_status_type"]
          user_id: string
        }
        Update: {
          created_at?: string
          credit_cost?: number
          id?: string
          image_url?: string | null
          project_id?: string
          prompt?: string
          resolution?: Database["public"]["Enums"]["resolution_type"]
          scene_type?: Database["public"]["Enums"]["scene_type_type"]
          status?: Database["public"]["Enums"]["generation_status_type"]
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "generations_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "projects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "generations_project_user_match"
            columns: ["project_id", "user_id"]
            isOneToOne: false
            referencedRelation: "projects"
            referencedColumns: ["id", "user_id"]
          },
        ]
      }
      plans: {
        Row: {
          created_at: string
          id: string
          max_projects: number | null
          max_resolution: Database["public"]["Enums"]["resolution_type"]
          model_support: Database["public"]["Enums"]["model_support_type"]
          monthly_credits: number
          most_popular: boolean | null
          name: string
          price_monthly: number
        }
        Insert: {
          created_at?: string
          id?: string
          max_projects?: number | null
          max_resolution: Database["public"]["Enums"]["resolution_type"]
          model_support: Database["public"]["Enums"]["model_support_type"]
          monthly_credits: number
          most_popular?: boolean | null
          name: string
          price_monthly: number
        }
        Update: {
          created_at?: string
          id?: string
          max_projects?: number | null
          max_resolution?: Database["public"]["Enums"]["resolution_type"]
          model_support?: Database["public"]["Enums"]["model_support_type"]
          monthly_credits?: number
          most_popular?: boolean | null
          name?: string
          price_monthly?: number
        }
        Relationships: []
      }
      projects: {
        Row: {
          cover_image_url: string | null
          created_at: string
          description: string | null
          id: string
          model_status: Database["public"]["Enums"]["model_status_type"]
          name: string
          user_id: string
        }
        Insert: {
          cover_image_url?: string | null
          created_at?: string
          description?: string | null
          id?: string
          model_status: Database["public"]["Enums"]["model_status_type"]
          name: string
          user_id: string
        }
        Update: {
          cover_image_url?: string | null
          created_at?: string
          description?: string | null
          id?: string
          model_status?: Database["public"]["Enums"]["model_status_type"]
          name?: string
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      generation_status_type: "pending" | "success" | "failed"
      model_status_type: "not_started" | "training" | "ready"
      model_support_type: "none" | "basic" | "full"
      resolution_type: "720p" | "1080p" | "4k"
      scene_type_type: "studio" | "lifestyle" | "modeling"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DefaultSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {
      generation_status_type: ["pending", "success", "failed"],
      model_status_type: ["not_started", "training", "ready"],
      model_support_type: ["none", "basic", "full"],
      resolution_type: ["720p", "1080p", "4k"],
      scene_type_type: ["studio", "lifestyle", "modeling"],
    },
  },
} as const

